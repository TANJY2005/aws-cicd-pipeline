from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"Status": "Secure API is running", "Version": "1.0"}