pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";

contract TestAdoption {
    // The address of the adoption contract to be tested
    Adoption adoption = Adoption(DeployedAddresses.Adoption());

    // The id of the pet that will be used for testing
    uint expectedPetId = 8;

    // The exptected owner of adopted pet is this contract
    address exptectedAdopter = address(this);

    function testUserCanAdoptPet() public {
        uint returnedId = adoption.adopt(expectedPetId);

        Assert.equal(returnedId, expectedPetId, "Adoption of the expected pet should match what is returned");
    }

    function testGetAdopterAddressByPetId() public {
        address adopter = adoption.adopters(expectedPetId);

        Assert.equal(adopter, exptectedAdopter, "Owner of the expted pet should be this contract");
    }

    function testGetAdopterAddressByPetIdInArray() public {
        // Store adopters in memory rather than contract's storage
        address[16] memory adopters = adoption.getAdopters();

        Assert.equal(adopters[expectedPetId], exptectedAdopter, "Owner of the exptected pet should be this contract");
    }
}