install:
	pip install -r requirements.txt

clean-py:
	find . | grep -E "__pycache__" | xargs rm -rf

clean:
	make clean-py
