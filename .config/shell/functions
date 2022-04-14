# Bash functions
# Author: Matt Ellis

# Reading man pages with vim
vman() { vim <(man $1); }

# Get a bibtex citation from a DOI
doi2bib()
{
		echo >> bib.bib;
		curl -s "https://api.crossref.org/works/$1/transform/application/x-bibtex" >> bib.bib;
		echo >> bib.bib;
}

fcd()
{
	cd $(fd -t d $1 | head -n 1)
}
