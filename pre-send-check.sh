#!/bin/bash
# Pre-send verification for the Lulubug pitch.
# Run the same day the link goes out. Every FAIL means a claim on the
# pitch or audit no longer matches their live site and must be fixed first.

set -u
PASS=0; FAIL=0
ok()   { echo "  PASS  $1"; PASS=$((PASS+1)); }
bad()  { echo "  FAIL  $1"; FAIL=$((FAIL+1)); }

echo "== Legal pages should still 404 =="
for path in privacy-policy terms-and-conditions cookie-policy; do
  code=$(curl -s -o /dev/null -w "%{http_code}" "https://www.lulubugsgarden.com/$path")
  [ "$code" = "404" ] && ok "/$path -> $code" || bad "/$path -> $code (claim says it 404s)"
done

echo "== Orphan product page should still be live =="
code=$(curl -s -o /dev/null -w "%{http_code}" "https://www.lulubugsgarden.com/product-page/printable-packet-episode-1")
[ "$code" = "200" ] && ok "orphan product page -> $code" || bad "orphan product page -> $code (claim says it's live)"

echo "== Homepage claims =="
HOME_HTML=$(mktemp)
curl -s "https://www.lulubugsgarden.com/" -o "$HOME_HTML"
grep -q "fbevents.js\|fbq(" "$HOME_HTML" && bad "Meta Pixel FOUND (claim says none)" || ok "no Meta Pixel"
grep -qiE "klaviyo|mailchimp|convertkit|beehiiv" "$HOME_HTML" && bad "email tool FOUND (claim says none)" || ok "no email tool"
grep -q "og:image" "$HOME_HTML" && bad "og:image FOUND (claim says none)" || ok "no og:image"
grep -qi "coming soon" "$HOME_HTML" && ok "hero 'Coming soon' still present" || bad "hero contradiction gone (claim stale)"
grep -qi "podcast" "$HOME_HTML" && bad "podcast now mentioned on homepage (claim stale)" || ok "podcast still absent from homepage"
grep -q "pfavico.ico" "$HOME_HTML" && ok "default Wix favicon still set" || bad "favicon changed (claim stale)"
grep -q 'content="bug"' "$HOME_HTML" && ok "placeholder etag 'bug' still present" || bad "etag placeholder gone (audit claim stale)"
grep -q "GTM-P2BL8D44" "$HOME_HTML" && ok "GTM container still loaded" || bad "GTM container changed (audit claim stale)"
grep -q "DSC_4864" "$HOME_HTML" && ok "camera-filename alt text still present" || bad "alt text fixed (audit claim stale)"
rm -f "$HOME_HTML"

echo "== About page: filmography still mangled =="
ABOUT_HTML=$(mktemp)
curl -s "https://www.lulubugsgarden.com/about-us" -o "$ABOUT_HTML"
grep -q "TOKYO COWBOY" "$ABOUT_HTML" && ok "ALL-CAPS filmography still present" || bad "filmography rewritten (claim stale)"
rm -f "$ABOUT_HTML"

echo "== Store sitemap entries still advertised =="
n=$(curl -s "https://www.lulubugsgarden.com/sitemap.xml" | grep -c "store-")
[ "$n" -ge 1 ] && ok "store sitemap entries present ($n)" || bad "store entries gone (audit claim stale)"

echo "== YouTube numbers (update the page if these moved) =="
MAIN=$(mktemp); POD=$(mktemp)
curl -sL "https://youtube.com/@lulubugsgarden" -o "$MAIN"
curl -sL "https://youtube.com/@lulubugspodcastforparents/videos" -o "$POD"
echo "  main channel: $(grep -oE '[0-9.]+[KM]? subscribers' "$MAIN" | sort -u | head -1), $(grep -oE '[0-9]+ videos' "$MAIN" | sort -u | tail -1)"
echo "  podcast:      $(grep -oE '[0-9.]+[KM]? subscribers' "$POD" | sort -u | head -1)"
echo "  pitch claims: 1,380 subs / 91 videos / 20 podcast subs. Update index.html + audit.html if drifted."
rm -f "$MAIN" "$POD"

echo ""
echo "== RESULT: $PASS pass, $FAIL fail =="
[ "$FAIL" -eq 0 ] && echo "Safe to send." || echo "Fix the FAIL lines before sending."
