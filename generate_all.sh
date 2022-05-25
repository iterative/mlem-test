set -exu
if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
  echo "set s3 access env vars"
  exit 1
fi
sh -c "cd custom_model && sh generate.sh"
sh -c "cd simple && sh generate.sh"
sh -c "cd dvc_pipeline && sh generate.sh"
sh -c "cd file_index && sh generate.sh"