variable "existing_sg_rules" {

      type = map(map(object({
        type        = string
        description = string
        from_port   = number
        to_port     = number
        protocol    = string
        cidr_blocks = list(string)
      })))
    }
variable sg_ids {
type = list(string)
default = []
#default = ["sg-0bd541cafc1955479","sg-0294c098f15df980e"]
}