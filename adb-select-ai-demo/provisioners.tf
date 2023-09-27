# Copyright © 2023, Oracle and/or its affiliates.
# All rights reserved. Licensed under the Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl.

resource "null_resource" "sqlcl-create-usr" {

        provisioner "local-exec" {
             command = <<-EOT

                # install the data
      
                sql -cloudconfig wallet_${var.db_name}.zip admin/${var.db_password}@'${local.conn_db}' @./scripts/init.sql
                
                echo 'Start running install-apex-workspace.sql script'
                sql -cloudconfig wallet_${var.db_name}.zip admin/${var.db_password}@'${local.conn_db}' @./scripts/install-apex-workspace.sql

                echo 'Start running tables.sql script to install data sets'
                sql -cloudconfig wallet_${var.db_name}.zip moviestream/watchS0meMovies#@'${local.conn_db}' @./tables.sql

                echo 'Start running install-apex-app.sql script to install the apex app'
                sql -cloudconfig wallet_${var.db_name}.zip moviestream/watchS0meMovies#@'${local.conn_db}' @./scripts/install-apex-app.sql

                rm -rf tables.sql     
            EOT
        }
depends_on = [module.adw_ecpus]
}

resource "local_file" "this" {
  content  = templatefile("./scripts/tables.sql.tmpl", { tag = var.tag, run_post_load_procedures = var.run_post_load_procedures, llm_secret = var.llm_secret  })
  filename = "./tables.sql"
}