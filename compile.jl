# https://www.youtube.com/watch?v=moHTgjdbfiQ POISOT LAB

using Weave

jmd_files = filter(endswith("Jmd"), readdir())

weave.(jmd_files)
tangle.(jmd_files)