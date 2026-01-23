from django.http import HttpResponse
from django.shortcuts import render

def index(request):
    return render(request, "index.html", {"message": "Hello from Django on AKS Kudos and awesome !"})

def health(request):
    return HttpResponse("OK")
