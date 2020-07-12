if [ -n "$(git diff --name-only origin/master... | grep -e
'routing'
)" ]; then
msg=$msg'/label ~Routing\n';
fi

if [ -n "$(git diff --name-only origin/master... | grep -e
'dns'
)" ]; then
msg=$msg'/label ~DNS\n';
fi

data="{\"body\":\"$msg\"}"

curl -sS -X POST -H "PRIVATE-TOKEN: $GITLAB_API_TOKEN" -H "Content-Type: application/json" -d "$data" \
$CI_SERVER_URL/api/v4/projects/$CI_PROJECT_ID/merge_requests/$CI_MERGE_REQUEST_IID/notes"