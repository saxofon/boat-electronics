#!/bin/bash

ssconvert -T Gnumeric_stf:stf_csv system-1.ods fd://1 | cut -d, -f1-5 | tr , '\t' > shoppinglist.txt

