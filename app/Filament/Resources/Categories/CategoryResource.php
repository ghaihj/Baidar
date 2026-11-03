<?php

namespace App\Filament\Resources\Categories;

use App\Filament\Resources\Categories\Pages\CreateCategory;
use App\Filament\Resources\Categories\Pages\EditCategory;
use App\Filament\Resources\Categories\Pages\ListCategories;
use App\Filament\Resources\Categories\Schemas\CategoryForm;
use App\Filament\Resources\Categories\Tables\CategoriesTable;
use App\Models\Category;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class CategoryResource extends Resource
{
    protected static ?string $model = Category::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'Category';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                TextInput::make('name_ar')
                    ->label('اسم الفئة (عربي)')
                    ->required()
                    ->maxLength(150),

                TextInput::make('name_en')
                    ->label('اسم الفئة (إنجليزي)')
                    ->required()
                    ->maxLength(150),

                FileUpload::make('image')
                    ->label('صورة الفئة')
                    ->image() // يضمن رفع الصور فقط
                    ->directory('categories') // يحفظها في مجلد storage/app/public/categories
                    ->visibility('public') // يجعلها متاحة للقراءة عبر الرابط
                    ->imageEditor() // (اختياري) يتيح لك قص الصورة قبل الرفع
                    ->nullable(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('id')->label('#'),
                TextColumn::make('name_ar')->label('الاسم (عربي)')->searchable(),
                TextColumn::make('name_en')->label('الاسم (إنجليزي)')->searchable(),
                TextColumn::make('plants_count')
                    ->label('عدد النباتات')
                    ->counts('plants')
                    ->badge()
                    ->color('success'),
                TextColumn::make('created_at')->label('أضيفت')->dateTime('Y-m-d'),
            ])
            ->actions([
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListCategories::route('/'),
            'create' => CreateCategory::route('/create'),
            'edit' => EditCategory::route('/{record}/edit'),
        ];
    }
}
