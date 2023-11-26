#!/bin/bash
# Prerequisite: 
# env variable CONFIGS_DIR. set as 'configs' as default in action.yml
# env variable SHA_START.
# env variable SHA_END.

file_list=$(git diff --name-only "${SHA_START}" "${SHA_END}")
echo file_list ${file_list}
for file in $file_list; do
  echo changed file "${file}"
  if [[ ${file} == ${CONFIGS_DIR}/*/Dockerfile ]] || [[ ${file} == ${CONFIGS_DIR}/*/copy_image.json  ]]; then
    file_name_stripped=${file/${CONFIGS_DIR}\//}
    # echo file_name_stripped ${file_name_stripped}
    file_name_strippedx=$(echo "${file_name_stripped}" | sed -E 's@([^/]+)/([^/]+)/(Dockerfile|copy_image.json)@\1:\2@g')
    # echo file_name_strippedx ${file_name_strippedx}
    config_names+=("${file_name_strippedx}")
  fi
done

# Sorted Unique chart names in json format
uniq_config_names=$(echo "${config_names[@]}" | tr ' ' '\n' | sort -u | jq -R -s -c 'split("\n")')
# remove the empty string from the json array
# echo uniq_config_names "${uniq_config_names}"

# TODO use jq's del() function instead of bash string replace.
uniq_config_names=${uniq_config_names/',""'/}
echo uniq_config_names "${uniq_config_names}"

echo "::set-output name=changed_configs::${uniq_config_names}"
