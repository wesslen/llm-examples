set-openai-key:
	llm keys set openai

set-mistral-key:
	llm keys set mistral

get-logs-path:
	dirname "$(llm logs path)"
# view last response
view-last-response:
	llm logs list -n 1
# summarize CLI API
summarize-cli-api:
	llm "Summarize this CLI API: $(llm --help)"
# suggest best practices for a local file
explain-local-code:
	cat myfile.py | llm "Explain this code. Provide any suggestions on ways to improve this code for programming best practices."
# suggest best practices for a github gist
explain-gist-code:
	curl -s https://gist.githubusercontent.com/wesslen/4b343f7be94cfbbae98318016c9a7c3c/raw/67da0b7c2cea15f3706519cb05ae21960e57d863/mapping.py | llm "Explain this code. Provide any suggestions on ways to improve this code for programming best practices."

# install instructions: https://simonwillison.net/2023/Dec/18/mistral/#mixtral-llama-cpp

add-mistral-7b:
	curl -LO 'https://huggingface.co/TheBloke/Mistral-7B-Instruct-v0.1-GGUF/resolve/main/mistral-7b-instruct-v0.1.Q4_K_M.gguf?download=true'
	llm llama-cpp add-model mistral-7b-instruct-v0.1.Q4_K_M.gguf

make-local-mistral-nfl:
	llm -m gguf \
	-o path mistral-7b-instruct-v0.1.Q4_K_M.gguf \
	'[INST] Write a .json of all 30 football teams including an index for each, team name, city, league (NFC v. AFC), and division.[/INST]'

make-local-mistral-mlb:
	llm -m gguf \
	-o path mistral-7b-instruct-v0.1.Q4_K_M.gguf \
	'[INST] Write a .json of all 30 baseball teams including an index for each, team name, city, league (American vs National), and division.[/INST]'

news-headlines:
	curl -s https://www.nytimes.com/ \
	| strip-tags .story-wrapper \
	| llm -s 'summarize the news to each article in 10 or less words. Keep only the top 10.'
