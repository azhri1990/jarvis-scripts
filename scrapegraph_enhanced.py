#!/data/data/com.termux/files/usr/bin/python3
import requests
from bs4 import BeautifulSoup
import json
import sys
import re

def scrape_advanced(url, extract_type="all"):
    try:
        headers = {'User-Agent': 'Mozilla/5.0'}
        response = requests.get(url, headers=headers, timeout=15)
        soup = BeautifulSoup(response.text, 'html.parser')
        
        data = {
            "url": url,
            "title": soup.title.string if soup.title else "No title",
            "meta_description": "",
            "links": [],
            "images": [],
            "headings": [],
            "paragraphs": [],
            "emails": [],
            "phone_numbers": []
        }
        
        # Meta description
        meta = soup.find('meta', attrs={'name': 'description'})
        if meta:
            data["meta_description"] = meta.get('content', '')
        
        # Links
        for a in soup.find_all('a', href=True):
            data["links"].append(a['href'])
        
        # Images
        for img in soup.find_all('img', src=True):
            data["images"].append(img['src'])
        
        # Headings
        for h in soup.find_all(['h1', 'h2', 'h3']):
            data["headings"].append(h.text.strip())
        
        # Paragraphs
        for p in soup.find_all('p'):
            data["paragraphs"].append(p.text.strip())
        
        # Emails
        email_pattern = r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
        data["emails"] = re.findall(email_pattern, response.text)
        
        # Phone numbers
        phone_pattern = r'[\+]?[\d\s\-\(\)]{8,20}'
        data["phone_numbers"] = re.findall(phone_pattern, response.text)
        
        return data
    except Exception as e:
        return {"error": str(e)}

if __name__ == "__main__":
    url = sys.argv[1] if len(sys.argv) > 1 else input("Enter URL: ")
    result = scrape_advanced(url)
    print(json.dumps(result, indent=2))
