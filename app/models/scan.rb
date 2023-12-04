class Scan < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_one :product

  def set_gpt_response
    prompt = "Examin the clothing label presented in the image and provide a JSON output, focusing solely on the overall fabric composition of the cloth. Exclude any detailed breakdowns like the material used for pockets or other specific parts,
    strictly adhering to RFC 8259 standards. Analyze the label text, even if presented in multiple languages, and provide the most comprehensible English translation.
    The JSON response should include the following keys with specific information:
    1. 'fabric_composition': An array containing the fabric composition details as listed on the label.
    2. 'origin_country': The country where the garment was manufactured. If this information is not available on the label, return 'nil'.
    3. 'brand': The brand name or manufacturer as indicated on the label.
    If this information is not available, return 'nil'.
    Please ensure the response excludes any explanatory text and strictly follows the JSON format.
    Example of a desired response: {'fabric_composition': ['80% Cotton', '20% Nylon'], 'origin_country': 'India', 'brand': 'Levis'}"

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

    update(response_chatgpt: new_content)
    return new_content
  end
end
