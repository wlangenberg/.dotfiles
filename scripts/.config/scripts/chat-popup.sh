convo=""
resp=""

while true; do
    read -p "You: " line
    [[ -z "$line" || "$line" = "/exit" ]] && break

    convo+=$'\n'"Human: $line"

    resp=""

    # Stream the response
    jq -Rs --arg model "gpt-4" \
        '{model:$model, stream:true, messages:[{role:"user", content:.}]}' <<<"$convo" |
    curl -s https://api.openai.com/v1/chat/completions \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d @- |
    while IFS= read -r line; do
        [[ "$line" != data:\ * ]] && continue
        payload="${line#data: }"
        [[ "$payload" == "[DONE]" ]] && break
        chunk=$(jq -r '.choices[0].delta.content // empty' <<<"$payload")
        printf "%s" "$chunk"
        resp+="$chunk"
    done

    echo
    echo
    convo+=$'\n'"Assistant: $resp"
done

echo 
read -n1 -s -r -p "Press 'c' to copy last GPT reply, any other key to close..." key
if [[ "$key" = "c" ]]; then
    printf "%s" "$resp" | pbcopy
fi

