.PHONY: clean build install test bump release

clean:
	rm -rf dist build .py2dist tests_dist *.egg-info .pytest_cache
	find . -name "*.so" -delete
	find . -name "*.pyd" -delete
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete

install:
	uv sync

test:
	# Basic test to ensure compilation works
	uv run py2dist -d tests/module_a -o tests_dist --quiet
	export PYTHONPATH=$$(pwd)/tests_dist && uv run python tests/main.py
	rm -rf tests_dist

build: clean
	uv build

# Usage: make bump v=0.1.1
bump:
	@if [ -z "$(v)" ]; then echo "Error: version argument 'v' is required (e.g., make bump v=0.1.1)"; exit 1; fi
	sed -i 's/^version = ".*"/version = "$(v)"/' pyproject.toml
	sed -i 's/^__version__ = ".*"/__version__ = "$(v)"/' py2dist/__init__.py
	@echo "Version bumped to $(v)"

# Usage: make release v=0.1.1
release: bump
	git add pyproject.toml py2dist/__init__.py
	git commit -m "Bump version to $(v)"
	git tag v$(v)
	git push origin main
	git push origin v$(v)
