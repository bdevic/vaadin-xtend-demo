package net.croz.vaadinxtenddemo.views.search

import com.vaadin.data.util.BeanItemContainer
import com.vaadin.navigator.View
import com.vaadin.navigator.ViewChangeListener$ViewChangeEvent
import com.vaadin.shared.ui.combobox.FilteringMode
import com.vaadin.ui.Alignment
import com.vaadin.ui.ComboBox
import com.vaadin.ui.FormLayout
import com.vaadin.ui.GridLayout
import com.vaadin.ui.HorizontalLayout
import com.vaadin.ui.UI
import com.vaadin.ui.VerticalLayout
import com.vaadin.ui.Window
import java.util.Date
import javax.annotation.PostConstruct
import net.croz.vaadinxtenddemo.components.GenericEditComponent
import net.croz.vaadinxtenddemo.model.Expense
import org.springframework.context.annotation.Scope
import org.springframework.stereotype.Component
import ru.xpoft.vaadin.VaadinView

import static extension net.croz.vaadinxtenddemo.api.ApiExtensions.*
import static extension net.croz.vaadinxtenddemo.api.BuilderExtensions.*

@Component
@Scope("prototype")
@VaadinView(SearchView::NAME)
class SearchView extends VerticalLayout implements View {
	public static val NAME = "Search"

	@PostConstruct
	def postConstruct() {
		this => [
			panel [
				caption = "Search parameters"
				content = new GridLayout(3, 1) => [
					spacing = true
					margin = true
					addComponent(
						new FormLayout() => [
							text [
								caption = "Expense owner"
							]
							text [
								caption = "Location"
							]
						], 0, 0)
					addComponent(
						new FormLayout() => [
							component(new ComboBox("Expense type", #["IT", "Marketing", "Sales", "Facilities"])) [
								inputPrompt = "Select expense type to search"
								//itemCaptionMode = ItemCaptionMode::ITEM
								filteringMode = FilteringMode::CONTAINS
							]
						], 1, 0)
					addComponent(
						new HorizontalLayout() => [
							setSizeFull
							button [
								alignment(Alignment::BOTTOM_RIGHT)
								caption = "Search"
							]
							button [
								alignment(Alignment::BOTTOM_RIGHT)
								caption = "Clear"
							]
						], 2, 0)
				]
			]
			table [
				caption = "Search results"
				setSizeFull
				addStyleName = "borderless"
				selectable = true
				columnCollapsingAllowed = true
				columnReorderingAllowed = true
				addItemClickListener(
					[
						if (doubleClick) {
							val expenseWnd = new Window("Input expense", new GenericEditComponent(typeof(Expense), itemId as Expense))
							UI::current.addWindow(expenseWnd)
							expenseWnd.center
							expenseWnd.bringToFront
						}
					])
				containerDataSource = new BeanItemContainer<Expense>(
					#[(new Expense() => [
						currentOwner = "John Smith"
						expenseType = "IT"
						expenseDate = new Date(System::currentTimeMillis)
						dueDate = new Date(System::currentTimeMillis)
						identifier = "1232"
						location = "5. floor"
						organizationalUnit = 100
						paymentDate = new Date(System::currentTimeMillis)
					]), (new Expense() => [
						currentOwner = "Robert Downing"
						expenseType = "Marketing"
						expenseDate = new Date(System::currentTimeMillis)
						dueDate = new Date(System::currentTimeMillis)
						identifier = "1232"
						location = "5. floor"
						organizationalUnit = 100
						paymentDate = new Date(System::currentTimeMillis)
					])])
				]
			]
		}

		override enter(ViewChangeEvent event) {
		}

	}
	