from tests.module_a import source_b
from tests.module_a.source_b import add

print(f"Loaded from: {source_b.__file__}")
print(f"Result: {add(1, 2)}")