# Update channel with nix-channel --update
# Install pkgs with nix-env -irf thisfile.nix
# -i install
# -f based on this file
# -r remove all the rest

# Might also want to run nix-collect-garbage from time to time

# See https://ianthehenry.com/posts/how-to-learn-nix/declarative-user-environment/

with import <nixpkgs> {}; [
	fd
	fzf
	htop
	jq
	mdbook
	mupdf
	osmium-tool
	rclone
	rink
	# Verify what version this would install. 23.11 repo is a bit behind
	# ruff
	tealdeer
	typst
	typstyle # Formatter for typst
	wget
	zola
	# Coq:
	# coq
	# coqPackages.coq-lsp
	# Money
	hledger
	# Speech to text
	openai-whisper
]
