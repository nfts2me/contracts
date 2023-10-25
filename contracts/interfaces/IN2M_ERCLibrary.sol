/** ---------------------------------------------------------------------------- //
 *                                                                               //
 *                                       .:::.                                   //
 *                                    .:::::::.                                  //
 *                                    ::::::::.                                  //
 *                                 .:::::::::.                                   //
 *                             ..:::.              ..                            //
 *                          .::::.                 ::::..                        //
 *                      ..:::..                    ::::::::.                     //
 *                   .::::.                        :::.  ..:::.                  //
 *               ..:::..                           :::.      .:::.               //
 *            .::::.                               :::.         .:::..           //
 *         .:::..               ..                 :::.            .::::.        //
 *     .::::.               ..:::=-                ::::               ..:::.     //
 *    :::.               .:::::::===:              ::::::.               .::::   //
 *   .::.            .:::::::::::=====.            ::::::::::.             .::.  //
 *   .::         .:::::::::::::::=======.          :::::::::::::..          ::.  //
 *   .::        .::::::::::::::::========-         :::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::==========:       :::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::============:     :::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::==============.   :::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::===============-. :::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::=================::::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::==================-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::==================-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::==================-::::::::::::::::        ::.  //
 *   .::        .:::::::::::::::::=================-::::::::::::::::        ::.  //
 *   .::        .:::::::::::::::: .-===============-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::   .==============-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::     :============-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::       :==========-::::::::::::::::        ::.  //
 *   .::        .::::::::::::::::        .-========-::::::::::::::::        ::.  //
 *   .::          .::::::::::::::          .=======-::::::::::::::.         ::.  //
 *   .::.             .::::::::::            .=====-::::::::::..            ::.  //
 *    :::..              ..::::::              :===-::::::..              .:::.  //
 *      .:::..               .:::                -=-:::.               .::::.    //
 *         .::::.            .:::                 ..                .::::.       //
 *            .::::.         .:::                               ..:::.           //
 *                .:::.      .:::                            .::::.              //
 *                   .:::..  .:::                        ..:::..                 //
 *                      .::::.:::                     .::::.                     //
 *                         ..::::                 ..:::..                        //
 *                             .:              .::::.                            //
 *                                     :::::.::::.                               //
 *                                    ::::::::.                                  //
 *                                    :::::::.                                   //
 *                                     .::::.                                    //
 *                                                                               //
 *                                                                               //
 *   Smart contract generated by https://nfts2me.com                             //
 *                                                                               //
 *   NFTs2Me. Make an NFT Collection.                                            //
 *   With ZERO Coding Skills.                                                    //
 *                                                                               //
 *   NFTs2Me is not associated or affiliated with this project.                  //
 *   NFTs2Me is not liable for any bugs or issues associated with this contract. //
 *   NFTs2Me Terms of Service: https://nfts2me.com/terms-of-service/             //
 * ----------------------------------------------------------------------------- */

/// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "./IN2M_ERCStorage.sol";

interface IN2M_ERCLibrary is IN2M_ERCStorage {
    function setAndRevealBaseURI(bytes32 baseURICIDHash) external;
    function changeMintPrice(uint256 newMintPrice) external;
    function contractURI() external view returns (string memory);
    function setContractURI(bytes32 newContractURIMetadataCIDHash) external;
    function setAffiliatesPercentageAndDiscount(uint16 userDiscount, uint16 affiliatePercentage, address affiliateAddress) external;
    function affiliateWithdraw(address affiliate) external;
    function withdrawERC20(address erc20Address) external;
    function withdrawERC20Pro(uint256 signatureExpireDate, uint n2mFee, address erc20Address, bytes calldata signature) external;
    function withdraw() external;
    function withdrawPro(uint256 signatureExpireDate, uint256 n2mFee, bytes calldata signature) external;
    function setReverseENSName(address rerverseResolver, string calldata collectionENSName) external;
    function initializeAndSetReverseENSName(address resolver, string calldata collectionENSName) external;
    function changePlaceholderImageCID(bytes32 newPlaceholderImageCIDHash) external;
    function setPhase(SalePhase newPhase) external;
    function setDropDate(uint256 dropDateTimestamp) external;
    function setDropAndEndDate(uint256 dropDateTimestamp, uint256 endDateTimestamp) external;
    function setMaxPerAddress(uint16 newMaxPerAddress) external;
    function isOperatorFilterRegistryEnabled() external view returns (bool);
    function enableOperatorFilterRegistry() external;
    function disableOperatorFilterRegistry() external;
    function collectionSize() external view returns (uint256);
    function randomTickets(address affiliate) external view returns (uint amount, uint blockNumberToReveal);
    function affiliatesInfo(address affiliate) external view returns (bool enabled, uint16 affiliatePercentage, uint16 userDiscount);
    function pendingAffiliateBalance(address affiliate) external view returns (uint256);
    function pendingTotalAffiliatesBalance() external view returns (uint256);
    function royaltyFee() external view returns (uint256);
    function withdrawnAmount() external view returns (uint256);
    function withdrawnERC20Amount(address erc20) external view returns (uint256);
    function erc20PaymentAddress() external view returns (address);
    function currentPhase() external view returns (SalePhase);
    function mintingType() external view returns (MintingType);
    function saleDates() external view returns (uint256 dropDateTimestamp, uint256 endDateTimestamp);
    function isOpen() external view returns (bool);
    function ownerMaxRevenue() external view returns (uint256);

}

