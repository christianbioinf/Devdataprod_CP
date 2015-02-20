.PHONY: all, clean

all: index.html

%.html: %.Rmd
	Rscript -e "library(slidify); knit2slides('$<', '$@')"
	# manually edit h.html afterwards to prepend http:
	@cp fig/h.html fig/h.html.save
	@cat fig/h.html.save | sed "s/src='\/\/code./src='http:\/\/code./" > fig/h.html

clean:
	@rm -f index.html index.md index.log


