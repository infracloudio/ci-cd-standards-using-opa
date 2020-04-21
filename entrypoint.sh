#!/bin/bash

set -e


if [[ $MANIFESTS_PATH_PATTERN == "*.yaml" ]] || [[ $MANIFESTS_PATH_PATTERN == "*.yml" ]]
then
    result=`opa eval -d "${LIBRARY_PATH}" -i $YAML_FILE "$DATA" --format=pretty`
    if [ "$result" != "[]" ]; then
       echo "One or more policies are violated in $MANIFESTS_PATH_PATTERN. $result"
      exit 1
    fi
else
    FILES=`find "${MANIFESTS_PATH_PATTERN}" -type f \( -name "*.yml" -o -name "*.yaml" \)`
    for YAML_FILE in $FILES
      do
         result=`opa eval -d "${LIBRARY_PATH}" -i $YAML_FILE data.kubernetes.admission.deny --format=pretty`
         if [ "$result" != "[]" ]; then
            echo "One or more policies are violated in $YAML_FILE. $result"
            exit 1
         fi
      done
fi

