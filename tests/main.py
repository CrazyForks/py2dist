from tests.module_a import source_b
from tests.module_a.source_b import add
from tests.module_a.mcp_service import get_service_info

print(f"Loaded from: {source_b.__file__}")
print(f"Result: {add(1, 2)}")
print(f"Service info: {get_service_info()}")