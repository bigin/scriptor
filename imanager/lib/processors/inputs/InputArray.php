<?php namespace Imanager;

class InputArray implements InputInterface
{
	/**
	 * @var stdClass - The vield value object
	 */
	protected $value;

	/**
	 * @var Field object
	 */
	protected $field;

	/**
	 * @var bool - default value if it wasn't defined in field settings menu
	 */
	protected $required = false;


	protected $default = [];

	/**
	 * @var null int
	 */
	public $errorCode = null;

	/**
	 * InputText constructor.
	 *
	 * @param Field $field
	 */
	public function __construct(Field $field)
	{
		$this->field = $field;

		$this->value = null;

		/**
		 * Set local config values if these was set in the field settings (IM-Menu)
		 */
		if($this->field->required) {
			$this->required = true;
		}
		if($this->field->minimum) {
			$this->minLen = $this->field->minimum;
		}
		if($this->field->maximum) {
			$this->maxLen = $this->field->maximum;
		}
		if(isset($this->field->default)) {
			$this->default = $this->field->default;
		}
	}

	/**
	 * This method checks the field inputs and sets the field contents.
	 * If an error occurs, the method returns an error code.
	 *
	 * @param $value
	 * @param bool $sanitize
	 *
	 * @return int|stdClass
	 */
	public function prepareInput($value, $sanitize = false)
	{
		// Set empty value, the input isn't required
		if(empty($value) && !$this->required) {
			$this->value = !isset($value) ? $this->default : $value;
			return true;
		}

		// Check input required
		if(($this->required) && empty($value)) {
			$this->errorCode = self::EMPTY_REQUIRED;
			return false;
		}

		// Sanitize input
		if($sanitize) {
			foreach($value as $k => $v) {
				$this->value[$this->sanitize($k)] = $this->sanitize($v);
			}
		} else {
			$this->value = $value;
		}

		// Sanitizer has wiped the value?
		if(!$this->value) {
			$this->errorCode = self::WRONG_VALUE_FORMAT;
			return false;
		}

		return true;
	}

	/**
	 * The method that is called when initiating item content
	 * and is relevant for setting the field content.
	 * However, since we do not require any special formatting
	 * of the output, we can accept the value 1 to 1 here.
	 *
	 * @return stdClass
	 */
	public function prepareOutput() { return $this->value; }

	/**
	 * This is the method used for sanitizing.
	 * ItemManager' Sanitizer method "text" will be used for this.
	 *
	 * @param $value
	 *
	 * @return mixed
	 */
	protected function sanitize($value)
	{
		return imanager('sanitizer')->text($value,
			array('maxLength' => $this->maxLen)
		);
	}
}