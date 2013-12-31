.PHONY: test spec

run:
	./bin/cgol

test:
	bundle exec guard

spec:
	bundle exec rspec
