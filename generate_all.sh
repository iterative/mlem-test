if [[ -z "${AWS_ACCESS_KEY}" ]]; then
  echo "set s3 access env vars"
  exit 1
fi
sh -c "cd simple && sh generate.sh"
sh -c "cd dvc_pipeline && sh generate.sh"