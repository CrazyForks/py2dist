def get_service_info():
    return {"name": "test_mcp", "version": "1.0.0"}

def handle_request(request):
    return {"status": "ok", "data": request}
