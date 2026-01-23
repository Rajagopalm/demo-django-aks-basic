from django.http import HttpResponse
from django.shortcuts import render

def index(request):
    return render(request, "index.html", {"message": "Hello from Django on AKS Kudos!"})

def health(request):
    return HttpResponse("OK")
