# Set up pythonpath. This is output of `pdm --pep582`, but linked to opt instead of
# Cellar to avoid version conflicts.
if [ -n "$PYTHONPATH" ]; then
    export PYTHONPATH='/usr/local/opt/pdm/libexec/lib/python3.10/site-packages/pdm/pep582':$PYTHONPATH
else
    export PYTHONPATH='/usr/local/opt/pdm/libexec/lib/python3.10/site-packages/pdm/pep582'
fi
