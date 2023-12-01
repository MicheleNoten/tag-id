class Scan < ApplicationRecord
  belongs_to :user

  has_one_attached :photo
  has_one :product

  def set_gpt_response
    prompt = "Read the clothing label in the image and just return a json with follwoing keys (fabric_compositon,origin_country,brand)
    Explanation of what each key should contain - fabric_compositon: 'the fabric composition as an Array of strings', 'origin_country': 'Country of manufactuing', 'brand': 'Brand name / maufactured on label'.
    Do not include any explanations, only provide a  RFC8259 compliant JSON response  following this format without deviation. Sample response - {'fabric_compositon': ['100% Cotton'], 'origin_country': 'India', 'brand': 'Levis'}"
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
