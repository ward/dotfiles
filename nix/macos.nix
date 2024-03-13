# Update channel with nix-channel --update
# Install pkgs with nix-env -irf thisfile.nix
# -i install
# -f based on this file
# -r remove all the rest

# See https://ianthehenry.com/posts/how-to-learn-nix/declarative-user-environment/

with import <nixpkgs> {}; [
	fd
	fzf
	htop
	jq
	mdbook
	mupdf
	rink
	tealdeer
	zola
	# Coq
	coq
	coqPackages.coq-lsp
	# Money
	hledger
]
