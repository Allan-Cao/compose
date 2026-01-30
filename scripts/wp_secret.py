import requests as r
import re

resp = r.get("https://api.wordpress.org/secret-key/1.1/salt/")

pattern = r"define\('([^']+)',\s*'([^']*)'\);"

for match in re.finditer(pattern, resp.text):
    name, value = match.groups()
    print(f'WP_{name}="{value}"')