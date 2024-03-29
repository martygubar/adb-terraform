# Copyright © 2023, Oracle and/or its affiliates.
# All rights reserved. Licensed under the Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl.

# Create ADW Database with Endpoint in private subnet or public ADW
module "adw_ecpus" {
  source = "./modules/cloud-foundation-library/database/adw_ecpus"
  adw_params = local.adw_params
}