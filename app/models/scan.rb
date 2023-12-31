class Scan < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_many :product, dependent: :destroy

  def set_gpt_response
    prompt = "Examin the clothing label presented in the image and provide a JSON output, focusing solely on the overall fabric composition of the cloth. Exclude any detailed breakdowns like the material used for pockets or other specific parts,
    strictly adhering to RFC 8259 standards. Analyze the label text, even if presented in multiple languages, and provide the most comprehensible English translation.
    The JSON response should include the following keys with specific information:
    1. 'fabric_composition': An object containing the fabric composition details as listed on the label, with each fabric type as a key and its percentage as the value. Add a suffix to the fabric name if it is either (certified, recycled, organic) or else don't add any suffix.
    2. 'origin_country': The country where the garment was manufactured. If this information is not available on the label, return 'nil'.
    3. 'brand': The brand name or manufacturer as indicated on the label.
    If this information is not available, return 'nil'.
    Please ensure the response excludes any explanatory text and strictly follows the JSON format.
    Example of a desired response: {'fabric_composition': {'cotton': '80%', 'nylon': '20%'}, 'origin_country': 'India', 'brand': 'Levis'}
    Another example of a desired response: {'fabric_composition': {'cotton organic': '70%', 'polyester recycled': '30%'}, 'origin_country': 'Brazil', 'brand': 'Adidas'}"

    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-4-vision-preview",
      messages: [{ role: "user", content: [
                      {
                        "type": "text",
                        "text": prompt
                      },
                      {
                        "type": "image_url",
                        "image_url": {
                          "url": photo.url,
                          "detail": "high"
                        }
                      }
                      ]
        }],
      max_tokens: 300
    })
    new_content = chaptgpt_response["choices"][0]["message"]["content"]
    cleaned_text = new_content.gsub(/^\`\`\`json\s|\s\`\`\`$/, '')

    update(response_chatgpt: cleaned_text, request_chatgpt: prompt)
    return new_content
  end
end
