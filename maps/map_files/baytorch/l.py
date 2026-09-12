import re

# Path to your .dmm file
input_file = "baytorch.dmm"
output_file = "map_cleaned.dmm"

# Regex to match the block for access_button
pattern = re.compile(
    r"(/obj/structure/machinery/access_button\s*\{([^}]*)\})",
    re.DOTALL
)

def remove_id_tag(properties: str) -> str:
    """Remove lines containing 'id_tag' from the properties."""
    lines = properties.split("\n")
    cleaned_lines = []
    for line in lines:
        stripped = line.strip()
        if stripped.startswith("id_tag "):
            continue
        cleaned_lines.append(line)
    return "\n".join(cleaned_lines)

with open(input_file, "r", encoding="utf-8") as f:
    data = f.read()

# Replace matches
def replacer(match):
    full_block = match.group(1)
    inside_props = match.group(2)
    cleaned_props = remove_id_tag(inside_props)
    return full_block.replace(inside_props, cleaned_props)

new_data = pattern.sub(replacer, data)

with open(output_file, "w", encoding="utf-8") as f:
    f.write(new_data)

print(f"Cleaned file saved to {output_file}")
