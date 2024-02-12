/** ---------------------------------------------------------------------------- //
 *                                                                               //
 *                Smart contract generated by https://nfts2me.com                //
 *                                                                               //
 *                                      .::.                                     //
 *                                    ......                                     //
 *                                ....        ::.                                //
 *                             .:..           :: ...                             //
 *                         ..:.               ::     ...                         //
 *                       ::.      ..:--       ::.       ...                      //
 *                      .:    ..:::::-==:     :::::..     :                      //
 *                      .:    :::::::-====:   ::::::::    :                      //
 *                      .:    :::::::-======. ::::::::    :                      //
 *                      .:    :::::::-=======-::::::::    :                      //
 *                      .:    :::::::-========-:::::::    :                      //
 *                      .:    ::::::::========-:::::::    :                      //
 *                      .:    :::::::. .======-:::::::    :                      //
 *                      .:    :::::::.   :====-:::::::    :                      //
 *                      .:     .:::::.     -==-:::::.     :                      //
 *                       .:.       .:.      .--:..      ...                      //
 *                          .:.     :.               ...                         //
 *                             .... :.           ....                            //
 *                                 .:.        .:.                                //
 *                                      .::::.                                   //
 *                                      :--.                                     //
 *                                                                               //
 *                                                                               //
 *   NFTs2Me. Make an NFT Collection.                                            //
 *   With ZERO Coding Skills.                                                    //
 *                                                                               //
 *   NFTs2Me is not associated or affiliated with this project.                  //
 *   NFTs2Me is not liable for any bugs or issues associated with this contract. //
 *   NFTs2Me Terms of Service: https://nfts2me.com/terms-of-service/             //
 *   More info at: https://docs.nfts2me.com/                                     //
 * ----------------------------------------------------------------------------- */

/// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC721} from "openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC7496, IERC5192, Common, IN2MCommon, DynamicNFT, NSMinting} from "./NSMinting.sol";
import {IERC165, IERC2981} from "openzeppelin/contracts/interfaces/IERC2981.sol";
import {Address} from "openzeppelin/contracts/utils/Address.sol";
import {LibString} from "solady/utils/LibString.sol";
import {Base64} from "solady/utils/Base64.sol";
import {IERC4907} from "../interfaces/IN2MCommon.sol";

/// @title NFTs2Me.com Smart Contracts for ERC-721.
/// @author The NFTs2Me Team
/// @notice Read our terms of service
/// @custom:security-contact security@nfts2me.com
/// @custom:terms-of-service https://nfts2me.com/terms-of-service/
/// @custom:website https://nfts2me.com/
contract N2MERC721NS is NSMinting, ERC721 {
    constructor(address payable factoryAddress, uint256 protocolFee) Common(factoryAddress, protocolFee) ERC721("","") payable {}

    function _requireTokenOwned(uint256 tokenId) internal view virtual override {
        _requireOwned(tokenId);
    }

    function _checkAuthorized(address owner, address spender, uint256 tokenId) internal view override(ERC721, Common) {
        super._checkAuthorized(owner, spender, tokenId);
    }

    /// @notice A distinct Uniform Resource Identifier (URI) for a given asset.
    /// @dev Throws if `_tokenId` is not a valid NFT. URIs are defined in RFC
    ///  3986. The URI may point to a JSON file that conforms to the "ERC721
    ///  Metadata JSON Schema".
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, Common)
        returns (string memory)
    {
        _requireTokenOwned(tokenId);

        if (_isDynamicNFT) {
            return DynamicNFT(address(this)).dynamicTokenURI(tokenId);
        }
        if (_mintingType == MintingType.CUSTOM_URI) {
            return _getIPFSURI(_customURICIDHashes[tokenId]);
        }

        string memory stringTokenId = LibString.toString(tokenId);
        string memory baseURI;
        if (_baseURICIDHash != 0) {
            baseURI = _getIPFSURI(_baseURICIDHash);
        } else {
            baseURI = _baseURIString;
        }

        if (_hasPlaceholder) {
            return string(
                abi.encodePacked(
                    'data:application/json;base64,',
                    Base64.encode(
                        abi.encodePacked(
                            '{"name":"Unrevealed Token #',
                            stringTokenId,
                            '","image":"',
                            baseURI,
                            '"}'
                        )
                    )
                )
            );                
        }

        return
            string(
                abi.encodePacked(
                    baseURI,
                    "/",
                    stringTokenId,
                    ".json"
                )
            );
    }

    function _ownerOf(uint256 tokenId)
        internal
        view
        override(ERC721, Common)
        returns (address)
    {
        return ERC721._ownerOf(tokenId);
    }

    function __mint(address to, uint256 tokenId)
        internal
        override
    {
        _mint(to, tokenId);
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name()
        public
        view
        override(ERC721, IN2MCommon)
        returns (string memory)
    {
        return _name;
    }

    function _update(
        address to, 
        uint256 tokenId, 
        address auth
    ) internal virtual override(ERC721) returns (address previousOwner) {
        previousOwner = ERC721._update(to, tokenId, auth);

        if (
            previousOwner != address(0) &&
            (_soulbound[tokenId] || _soulboundCollection)
        ) revert NonTransferrableSoulboundNFT();

        if (to == address(0)) {
            /// Burn
            unchecked {
                ++_burnedTokens;
            }
        } else {
            /// Mint or regular transfer
            /// Check MaxPerAddress
            if (_maxPerAddress != 0) {
                if (balanceOf(to) > _maxPerAddress) revert MaxPerAddressExceeded();
            }
        }

        if (_isDynamicNFT) {
            Address.functionDelegateCall(address(_dynamicNFT), abi.encodeWithSelector(DynamicNFT.tokenUpdate.selector, previousOwner, to, tokenId));
        }
    }

    /// @notice Query if a contract implements an interface
    /// @param interfaceId The interface identifier, as specified in ERC-165
    /// @dev Interface identification is specified in ERC-165. This function uses less than 30,000 gas.
    /// @return `true` if the contract implements `interfaceId` and `interfaceId` is not 0xffffffff, `false` otherwise
    function supportsInterface(bytes4 interfaceId)
        public
        pure
        override(ERC721, IERC165)
        returns (bool)
    {
        if (interfaceId == IERC165_INTERFACE_ID) return true;         
        if (interfaceId == IERC173_INTERFACE_ID) return true;         
        if (interfaceId == IERC721_INTERFACE_ID) return true;         
        if (interfaceId == IERC721METADATA_INTERFACE_ID) return true; 
        if (interfaceId == IERC2981_INTERFACE_ID) return true;        
        if (interfaceId == IERC4907_INTERFACE_ID) return true;        
        if (interfaceId == IERC7496_INTERFACE_ID) return true;        
        return (interfaceId == IERC5192_INTERFACE_ID);                
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol()
        public
        view
        virtual
        override(IN2MCommon, ERC721)
        returns (string memory)
    {
        return _symbol;
    }

    function burn(uint256 tokenId) external payable {
        _update(address(0), tokenId, msg.sender);
    }

    /// @notice Enable or disable approval for a third party ("operator") to manage
    ///  all of `msg.sender`'s assets
    /// @dev Emits the ApprovalForAll event. The contract MUST allow
    ///  multiple operators per owner.
    /// @param operator Address to add to the set of authorized operators
    /// @param approved True if the operator is approved, false to revoke approval
    function setApprovalForAll(address operator, bool approved) public override(ERC721) onlyAllowedOperatorApproval(operator) {
        ERC721.setApprovalForAll(operator, approved);
    }

    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param operator The new approved NFT controller
    /// @param tokenId The NFT to approve
    function approve(address operator, uint256 tokenId) public override(ERC721) onlyAllowedOperatorApproval(operator) {
        ERC721.approve(operator, tokenId);
    }

    function _isAuthorized(address owner, address spender, uint256 tokenId) internal view override(ERC721) returns (bool) {
        _isOperatorAllowed(spender);
        return ERC721._isAuthorized(owner, spender, tokenId);
    }

    /// @notice Query if an address is an authorized operator for another address
    /// @param owner The address that owns the NFTs
    /// @param operator The address that acts on behalf of the owner
    /// @return True if `operator` is an approved operator for `owner`, false otherwise
    function isApprovedForAll(address owner, address operator)
    public
    view
    virtual
    override(ERC721)
    returns (bool)
    {

        if (operator == OPENSEA_CONDUIT && _operatorFilterStatus == OperatorFilterStatus.DISABLED) return true;
        if (operator == N2M_CONDUIT) return true;

        return ERC721.isApprovedForAll(owner, operator);
    }

}
