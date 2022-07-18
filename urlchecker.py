import requests

# read a text file that contains a list of urls to be checked
with open('urls.txt', 'r') as f:
    urls = f.readlines()

# function to check if the url is reachable
def check_url(url):
    try:
        r = requests.get(url, timeout=5)
        if r.status_code == 200:
            return True
        else:
            return False
    except:
        return False

for url in urls:
    url = url.strip()
    if check_url(url):
        print("{} IS STILL UP!".format(url))
    else:
        print("{} is not reachable".format(url))
