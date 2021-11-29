#!/bin/bash

for f in *rar
do
  unrar e "$f"
done
