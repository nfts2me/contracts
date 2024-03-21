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
pragma solidity ^0.8.25;

import "./important/README.sol";

/// @title NFTs2Me.com Smart Contracts Version
/// @author The NFTs2Me Team
/// @notice Read our terms of service
/// @custom:security-contact security@nfts2me.com
/// @custom:terms-of-service https://nfts2me.com/terms-of-service/
/// @custom:website https://nfts2me.com/
abstract contract N2MVersion is Readme {
    /// @notice Current version of the nfts2me.com contracts.
    function n2mVersion() virtual external pure returns (uint256) {
        return 2024;
    }

}
