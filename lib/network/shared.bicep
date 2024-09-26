metadata author = 'rwbr@outlook.de'
metadata repository = 'https://github.com/r-wbr/bicep-advanced-toolset'
metadata version = '2.1.3'

// WIP - Not ready for production usage.

func setAddressSpaceConnectivity(addressSpace string) string => cidrSubnet(addressSpace, 21, 30)

func setAddressSpaceIdentity(addressSpace string) string => cidrSubnet(addressSpace, 22, 59)

func setAddressSpaceManagement(addressSpace string) string => cidrSubnet(addressSpace, 22, 58)

func setAddressSpacehubVirtualNetworkPrimary(addressSpace string) string => cidrSubnet(addressSpace, 23, 124)

func setAddressSpacehubVirtualNetworkSecondary(addressSpace string) string => cidrSubnet(addressSpace, 23, 125)

func setAddressSpacehubVirtualWan(addressSpace string) string => cidrSubnet(addressSpace, 23, 126)

@export()
@description('Calculates the address space for the corresponsing item.')
func getAddressSpace(addressSpace string) object => {
  connectivity: setAddressSpaceConnectivity(addressSpace)
  identity: setAddressSpaceIdentity(addressSpace)
  management: setAddressSpaceManagement(addressSpace)
  hubVirtualNetworkPrimary: setAddressSpacehubVirtualNetworkPrimary(addressSpace)
  hubVirtualNetworkSecondary: setAddressSpacehubVirtualNetworkSecondary(addressSpace)
  virtualWan: setAddressSpacehubVirtualWan(addressSpace)
}
