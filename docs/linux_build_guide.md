# Linux Build Guide

## Determining Package Size
To determine the installed size for your Linux package configuration, you can use the following script:

```bash
#!/bin/bash

# Build the Linux app
flutter build linux

# Get size in KB and add 17% buffer for runtime dependencies
SIZE_KB=$(du -sk build/linux/x64/release/bundle | cut -f1)
BUFFER_SIZE_KB=$(($SIZE_KB + ($SIZE_KB * 17 / 100)))

echo "Actual bundle size: $SIZE_KB KB"
echo "Recommended installed_size (with 17% buffer): $BUFFER_SIZE_KB KB"
```

Save this as `get_package_size.sh` in your project root and make it executable:
```bash
chmod +x get_package_size.sh
```

### Usage
1. Run the script:
   ```bash
   ./get_package_size.sh
   ```
2. Use the output value for `installed_size` in your `linux/packaging/deb/make_config.yaml` file:
   ```yaml
   installed_size: 75700  # Replace with the value from the script
   ```

### Why add a buffer?
The 17% buffer is added to account for:
- Runtime dependencies
- Future updates
- Potential additional assets
- Prevent installation issues on systems with limited space

### Notes
- The installed size should be specified in kilobytes (KB)
- Always round up the buffer size to be safe
- Re-run this script after significant changes to your app (new assets, dependencies, etc.)