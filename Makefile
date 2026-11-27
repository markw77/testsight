SHELL := /bin/bash

.PHONY: help lint pre-commit

help:
	@echo "Targets: lint pre-commit"

lint:
	@for t in yamllint; do \
	  command -v $$t >/dev/null 2>&1 || { \
	    echo "error: missing lint tool: $$t (run 'make pre-commit' after installing pre-commit)" >&2; \
	    exit 1; \
	  }; \
	done
	@echo "yamllint"
	@yamllint -c .yamllint .
	@echo "lint ok"

pre-commit:
	@command -v pre-commit >/dev/null 2>&1 || { \
	  echo "error: pre-commit not found; install with 'pip install pre-commit' or 'uv tool install pre-commit'" >&2; \
	  exit 1; \
	}
	@echo "pre-commit"
	pre-commit run --all-files
	@echo "pre-commit ok"
