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
pragma solidity ^0.8.24;

import '../important/README.sol';
import './IN2MCommon.sol';

interface IN2MFactory is Readme {
    error InvalidSignature();
    error FailedToDeploy();
    error FactoryBalanceDecreased();
    error InvalidLengths();
    error BalanceInvariant();

    function createCollectionN2M_000oEFvt(
        bytes calldata collectionInformation,
        bytes32 collectionId,
        bytes32 implementationType
    ) payable external;

    function createCollection(
        bytes calldata collectionInformation,
        bytes32 collectionId,
        bytes32 implementationType
    ) payable external;

    function delegatedCreation(
        bytes calldata collectionInformation,
        address owner,
        bytes32 collectionId,
        bytes32 implementationType,
        bytes calldata signature
    ) external payable;

    function createNewDynamic(
        address dynamicAddress,
        bytes32 salt,
        bytes calldata initInformation
    ) external payable;

    function multicallN2M_001Taw5z(uint256 collectionAndSelfcalls, bytes[] calldata data) external payable;

    function multicall(uint256 collectionAndSelfcalls, bytes[] calldata data) external payable;

    function multicallMulticollection(uint256[] calldata collectionsAndCalls, uint256[] calldata collectionsValues, bytes[] calldata data) external payable;

    function predictDeterministicAddress(bytes32 implementationType, bytes32 collectionId) external view returns (address);

    function getImplementation(bytes32 implementationType) external view returns (address);

}