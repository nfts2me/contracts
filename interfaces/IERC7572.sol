// SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.25;

interface IERC7572 {
  function contractURI() external view returns (string memory);

  event ContractURIUpdated();
}