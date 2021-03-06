<?php

namespace Scriptor;

class Settings extends Module
{
	/**
	 * Default execute module method
	 */
	public function execute()
	{
		$this->pageContent = $this->renderSettingsEditor();
		$this->breadcrumbs = '<li><a href="../">'.$this->i18n['dashboard_menu'].'</a><i 
			class="gg-chevron-right"></i></li><li><span>'.
		$this->i18n['settings_menu'].'</span></li>';

		$this->renderMessages();
	}

	protected function renderSettingsEditor()
	{
		return '<h1>'.$this->i18n['settings_page_header'].'</h1>'.
			   '<p>'.$this->i18n['settings_page_text'].'</p>';
	}
}