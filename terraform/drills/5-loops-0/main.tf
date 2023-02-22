# Create the random string that we'll use throughout the exercise
resource "random_uuid" "guid" {}

# Well use our account id to make things unique
data "aws_caller_identity" "current" {}


# Creating S3 buckets using the for_each looping construct

resource "aws_s3_bucket" "bucket" {
    for_each = {
    "bucket1-${data.aws_caller_identity.current.account_id}" = {},
    "bucket2-${data.aws_caller_identity.current.account_id}" = {},
    "bucket3-${data.aws_caller_identity.current.account_id}" = {}
    }

    bucket = each.key
}

# Looping over a list
# Suppose we had a list as follows and we wanted to loop over the list to create buckets
# with the list items as prefixes to our buckets

locals {
    # we've defined the list locally, but it could also have been in a variables.tf
    fruits = [
        "apple",
        "peach",
        "orange"
        ]
}

# Create 3 buckets with names beginning with each fruit with a guid appended.
resource "aws_s3_bucket" "fruits" {
    # for_each can only be assigned a map or set of strings.
    # since we had a list of strings, we use the toset() function to convert it into a set
    for_each = toset(local.fruits)
    bucket   = "${each.value}-${random_uuid.guid.result}"
}

# Let's use a map in a for_each loop and use the key and value
locals {
    animals = {
        "bears"  = "hibernate", # here, the key is bears and the value is hibernate
        "dogs"   = "bark",
        "horses" = "gallup"
    }

    # We loop over the key and value of the map to create a list of strings.
    # One of the strings will be "bears hibernate".
    # KEEP IN MIND: The order of maps is NOT guaranteed. This means the animal_activities list
    # may be different for each person running this terraform.
    animal_activities = [
        for animal, activity in local.animals: 
            "${animal} ${activity}"        
        ]
   
    # Now that we have a list of animal activity strings, we join them into a single string using the join function
    animal_story = join(", ", local.animal_activities) 
}

# Let's write it to a file named ignoreMe-animal-activities.txt, just to view it.
resource "local_file" "doc" {
    filename = "${path.module}/ignoreMe-animal-activities.txt"
    content = local.animal_story
}