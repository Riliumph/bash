###
# Show top 10 disk usage entries in current directory
champion_disk_usage()
{
  du -h | sort -hr | head
}
