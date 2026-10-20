#!/usr/bin/env python3
"""
Build both the main order page (at root /) and the brand site (at /brand)
for deployment on Vercel or any static host.
"""
import os
import shutil
import subprocess

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))

def build_order_page():
    print("==> Building Order Page (Main Site at /)...")
    order_dir = os.path.join(ROOT_DIR, 'order-page')
    subprocess.run(['python3', 'build.py'], cwd=order_dir, check=True)
    
    # Copy dist/index.html to root
    shutil.copy2(os.path.join(order_dir, 'dist', 'index.html'), os.path.join(ROOT_DIR, 'index.html'))
    
    # Copy dist/media to root/media
    root_media = os.path.join(ROOT_DIR, 'media')
    os.makedirs(root_media, exist_ok=True)
    order_media = os.path.join(order_dir, 'dist', 'media')
    for f in os.listdir(order_media):
        src = os.path.join(order_media, f)
        dst = os.path.join(root_media, f)
        if os.path.isfile(src):
            shutil.copy2(src, dst)
    print("✓ Order Page ready at root index.html and media/")

def build_brand_site():
    print("==> Building Brand Site (at /brand)...")
    brand_dir = os.path.join(ROOT_DIR, 'brand-site')
    subprocess.run(['python3', 'build.py'], cwd=brand_dir, check=True)
    
    # Copy dist into brand/
    target_brand = os.path.join(ROOT_DIR, 'brand')
    os.makedirs(target_brand, exist_ok=True)
    
    shutil.copy2(os.path.join(brand_dir, 'dist', 'index.html'), os.path.join(target_brand, 'index.html'))
    
    brand_media = os.path.join(brand_dir, 'dist', 'media')
    target_media = os.path.join(target_brand, 'media')
    if os.path.exists(target_media):
        shutil.rmtree(target_media)
    shutil.copytree(brand_media, target_media)
    print("✓ Brand Site ready at brand/index.html and brand/media/")

if __name__ == '__main__':
    build_order_page()
    build_brand_site()
    print("\nAll builds completed successfully!")
