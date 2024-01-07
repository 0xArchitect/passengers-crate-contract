// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {CompoundableERC721A} from "./CompoundableERC721A.sol";

contract cNFTImplementation is CompoundableERC721A {
    
    uint256 public MAX_SUPPLY;
    
    // this mapping keeps track of the controllers
    // controllerAddress => bool
    mapping (address => bool) public isController;
    
    
    modifier onlyController() {
        require(isController[msg.sender], "Not a controller");
        _;
    }
    
    /**
        * @dev Used to initialize the contract
        * @param name The name of the token
        * @param symbol The symbol of the token
    */
    function initialize(string memory name, string memory symbol) public initializer {
        __CompoundableNFT_init(name,symbol);
        MAX_SUPPLY = 3200;
    }
    
    /**
        * @dev Used to add a controller
        * @param _controller The address of the controller
    */
    function addController(address _controller) external onlyOwner {
        isController[_controller] = true;
    }
    
    /**
        * @dev Used to mint a token
        * @param to The address of the user to mint
    */
    function mintToken(address to, uint256 tokenId) external onlyController {
        require(totalSupply()+ 1 <= MAX_SUPPLY, "Max supply reached");
        _mint(to, tokenId);
    }
    
    /**
        * @dev Used to set the max supply
        * @param maxSupply The max supply
    */
    function setMaxSupply(uint256 maxSupply) external onlyOwner {
        MAX_SUPPLY = maxSupply;
    }
    
    /**
        * @dev Used to burn a token
        * @dev This function is only callable by the controller
        * @param tokenId The id of the token to burn
    */
    function burnToken(uint256 tokenId) external onlyController {
        _burn(tokenId);
    }
    
    /**
        * @dev Used to check if a token exists
        * @param tokenId The id of the token to check
    */
    function tokenExists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }
    
    function attachToken(
        address[] memory tailAddresses,
        uint256[] memory tailIds,
        uint256[] memory headIds
    ) external {
        attach(tailAddresses,tailIds,headIds);
    }
    
    function detachToken(
        address[] memory tailAddresses,
        uint256[] memory tailIds,
        uint256[] memory headIds
    ) external {
        detach(tailAddresses,tailIds,headIds);
    }
    
    function burnBatchTokens(uint256[] memory tokenIds) external onlyController {
        for(uint256 i = 0; i < tokenIds.length; i++) {
            _burn(tokenIds[i]);
        }
    }
}
