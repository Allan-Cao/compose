-- WordPress Domain Migration Script
-- Reference: https://developer.wordpress.org/advanced-administration/upgrade/migrating/
--
-- Usage:
-- 1. Set @old_url and @new_url below
-- 2. Replace TABLE_PREFIX_ with your actual prefix (e.g., wp_, mysite_)
-- 3. Run: docker exec -it <project>_db mariadb -u root -p<password> <database> < wp_site_migration.sql

SET @old_url = 'https://old-domain.com';
SET @new_url = 'https://new-domain.com';

-- Update core site URLs
UPDATE TABLE_PREFIX_options SET option_value = @new_url WHERE option_name = 'siteurl';
UPDATE TABLE_PREFIX_options SET option_value = @new_url WHERE option_name = 'home';

-- Update URLs in post content (NOT guid - per WordPress docs)
UPDATE TABLE_PREFIX_posts SET post_content = REPLACE(post_content, @old_url, @new_url);

-- Update URLs in post meta (skip serialized data)
UPDATE TABLE_PREFIX_postmeta SET meta_value = REPLACE(meta_value, @old_url, @new_url)
WHERE meta_value NOT LIKE '%:{%';

-- Verify changes
SELECT option_name, option_value FROM TABLE_PREFIX_options WHERE option_name IN ('siteurl', 'home');
