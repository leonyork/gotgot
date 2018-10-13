if [ ! -f static/index.html ]; then
    echo "index.html not found"
    exit 1
fi

if [ ! -f static/error.html ]; then
    echo "error.html not found"
    exit 1
fi