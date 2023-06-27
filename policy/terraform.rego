package analysis

import data.input

default allow = false
allow {
    not public_block_bucket_exists
}

default public_block_bucket_exists = false
public_block_bucket_exists {
    some i
    input.planned_values.root_module.resources[i].type == "aws_s3_bucket_public_access_block"
    access_block := input.planned_values.root_module.resources[i].values
    print(access_block)
    not is_public_access_blocked(access_block)
}

is_public_access_blocked(access_block) {
    access_block.block_public_acls
    access_block.block_public_policy
    access_block.ignore_public_acls
    access_block.restrict_public_buckets
}
