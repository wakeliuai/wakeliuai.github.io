import os
import markdown
from jinja2 import Environment, FileSystemLoader
import re
import shutil

BASE_DIR = "/Volumes/Lisa/Projects/Website"
SRC_CONTENT = os.path.join(BASE_DIR, "src", "content")
SRC_TEMPLATES = os.path.join(BASE_DIR, "src", "templates")

def build_posts(env):
    md = markdown.Markdown(extensions=['meta', 'fenced_code', 'tables'])
    posts = []
    post_template = env.get_template("post.html")
    
    for filename in os.listdir(SRC_CONTENT):
        if filename.endswith(".md"):
            with open(os.path.join(SRC_CONTENT, filename), "r", encoding="utf-8") as f:
                text = f.read()
            
            md.reset()
            html_content = md.convert(text)
            meta = md.Meta
            
            title = meta.get("title", [filename])[0]
            date_str = meta.get("date", [""])[0]
            
            preview = re.sub('<[^<]+>', '', html_content)[:150] + "..."
            slug = filename.replace(".md", ".html")
            url = f"pages/{slug}"
            
            posts.append({
                "title": title.strip('"\''),
                "date": date_str.strip('"\''),
                "content": html_content,
                "preview": preview,
                "url": url,
                "slug": slug
            })
            
    posts.sort(key=lambda x: x["date"], reverse=True)
    
    # Ensure pages dir exists
    os.makedirs(os.path.join(BASE_DIR, "pages"), exist_ok=True)
    
    for post in posts:
        output_html = post_template.render(
            title=f'{post["title"]} | Wake Liu',
            content=post["content"],
            base_path="../"
        )
        with open(os.path.join(BASE_DIR, "pages", post["slug"]), "w", encoding="utf-8") as f:
            f.write(output_html)
            
    return posts

def build_pages(env, posts):
    blog_template = env.get_template("blog_index.html")
    with open(os.path.join(BASE_DIR, "pages", "blog.html"), "w", encoding="utf-8") as f:
        f.write(blog_template.render(title="Thoughts | Wake Liu", posts=posts, base_path="../"))
        
    index_template = env.get_template("index.html")
    with open(os.path.join(BASE_DIR, "index.html"), "w", encoding="utf-8") as f:
        f.write(index_template.render(title="Wake Liu | Silence & Systems", recent_posts=posts[:3], base_path=""))

if __name__ == "__main__":
    print("Building site to root...")
    env = Environment(loader=FileSystemLoader(SRC_TEMPLATES))
    posts = build_posts(env)
    build_pages(env, posts)
    print(f"Site built successfully! {len(posts)} posts generated.")
