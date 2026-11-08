<?php

namespace App\Filament\Resources\Plants;

use App\Filament\Resources\Plants\Pages\CreatePlant;
use App\Filament\Resources\Plants\Pages\EditPlant;
use App\Filament\Resources\Plants\Pages\ListPlants;
use App\Models\Plant;
use BackedEnum;
use Filament\Actions\DeleteAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;


class PlantResource extends Resource
{
    protected static ?string $model = Plant::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedBeaker;

    protected static ?string $navigationLabel = 'النباتات';
    protected static ?string $modelLabel = 'نبتة';
    protected static ?string $pluralModelLabel = 'النباتات';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                // القسم الأول: المعلومات الأساسية
                Section::make('المعلومات الأساسية')
                    ->schema([
                        TextInput::make('name_ar')
                            ->label('الاسم العربي')
                            ->required()
                            ->maxLength(150),
                        TextInput::make('name_en')
                            ->label('الاسم الإنجليزي')
                            ->maxLength(150),
                        Select::make('category_id')
                            ->label('الفئة')
                            ->relationship('category', 'name_ar')
                            ->required()
                            ->preload(),
                        Select::make('region_name_ar')
                            ->label('المنطقة')
                            ->options([
                                'الشمالية' => 'الشمالية',
                                'الجنوبية' => 'الجنوبية',
                                'الشرقية' => 'الشرقية',
                                'الغربية' => 'الغربية',
                                'الوسطى' => 'الوسطى',
                                'الساحلية' => 'الساحلية',
                            ])
                            ->required()
                            ->reactive()
                            ->afterStateUpdated(function ($state, callable $set) {
                                // تحديث الاسم الإنجليزي تلقائياً بناءً على العربي
                                $map = [
                                    'الشمالية' => 'Northern',
                                    'الجنوبية' => 'Southern',
                                    'الشرقية' => 'Eastern',
                                    'الغربية' => 'Western',
                                    'الوسطى' => 'Central',
                                    'الساحلية' => 'Coastal',
                                ];
                                $set('region_name_en', $map[$state] ?? null);
                            }),
                        TextInput::make('region_name_en')
                            ->label('المنطقة (إنجليزي)')
                            ->maxLength(100)
                            ->disabled() // لا يمكن تعديله يدوياً لأنه يتحدث تلقائياً
                            ->dehydrated(),
                        Select::make('season')
                            ->label('الفصل')
                            ->options([
                                'ربيع' => 'ربيع',
                                'صيف' => 'صيف',
                                'خريف' => 'خريف',
                                'شتاء' => 'شتاء',
                            ])
                            ->required(),
                    ])->columns(2),

                // القسم الثاني: الصورة والوصف
                Section::make('الوصف والصورة')
                    ->schema([
                        FileUpload::make('image')
                            ->label('صورة النبات')
                            ->image()
                            ->directory('plants')
                            ->visibility('public')
                            ->imageEditor()
                            ->maxSize(2048)
                            ->nullable(),
                        Textarea::make('description_ar')
                            ->label('الوصف (عربي)')
                            ->rows(3),
                        Textarea::make('description_en')
                            ->label('الوصف (إنجليزي)')
                            ->rows(3),
                    ])->columns(1),

                // القسم الثالث: بيانات التربة والمياه
                Section::make('التربة والمياه')
                    ->schema([
                        TextInput::make('soil_type_ar')->label('نوع التربة (عربي)'),
                        TextInput::make('soil_type_en')->label('نوع التربة (إنجليزي)'),
                        TextInput::make('soil_ph_min')->label('أدنى pH')->numeric()->step(0.1),
                        TextInput::make('soil_ph_max')->label('أقصى pH')->numeric()->step(0.1),
                        TextInput::make('water_amount_mm')->label('كمية الري (مم/أسبوع)')->numeric(),
                        TextInput::make('watering_frequency')->label('عدد مرات الري')->placeholder('مثال: مرتين أسبوعياً'),
                    ])->columns(3),

                // القسم الرابع: الحرارة والرطوبة والشمس
                Section::make('الحرارة والرطوبة والشمس')
                    ->schema([
                        TextInput::make('temp_min_c')->label('أدنى حرارة (°م)')->numeric()->step(0.1),
                        TextInput::make('temp_max_c')->label('أقصى حرارة (°م)')->numeric()->step(0.1),
                        TextInput::make('humidity_min')->label('أدنى رطوبة (%)')->numeric(),
                        TextInput::make('humidity_max')->label('أقصى رطوبة (%)')->numeric(),
                        TextInput::make('sun_hours_min')->label('أدنى ساعات شمس')->numeric(),
                        TextInput::make('sun_hours_max')->label('أقصى ساعات شمس')->numeric(),
                    ])->columns(3),

                // القسم الخامس: التقويم والإرشادات
                Section::make('التقويم والإرشادات')
                    ->schema([
                        TextInput::make('planting_start_month')->label('بداية الزراعة (1-12)')->numeric()->minValue(1)->maxValue(12),
                        TextInput::make('planting_end_month')->label('نهاية الزراعة (1-12)')->numeric()->minValue(1)->maxValue(12),
                        TextInput::make('harvest_start_month')->label('بداية الحصاد (1-12)')->numeric()->minValue(1)->maxValue(12),
                        TextInput::make('harvest_end_month')->label('نهاية الحصاد (1-12)')->numeric()->minValue(1)->maxValue(12),
                        TextInput::make('spacing_cm')->label('المسافة بين النباتات (سم)')->numeric(),
                        Textarea::make('fertilization_notes')->label('إرشادات التسميد')->rows(2)->columnSpanFull(),
                        Textarea::make('common_diseases')->label('الأمراض الشائعة')->rows(2)->columnSpanFull(),
                    ])->columns(3),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('image')
                    ->label('الصورة')
                    ->disk('public')
                    ->circular(),
                TextColumn::make('name_ar')
                    ->label('الاسم العربي')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('category.name_ar')
                    ->label('الفئة')
                    ->badge()
                    ->color('success'),
                TextColumn::make('region_name_ar')
                    ->label('المنطقة')
                    ->searchable()
                    ->sortable(),
                TextColumn::make('season')
                    ->label('الفصل')
                    ->badge()
                    ->color('info'),
                TextColumn::make('created_at')
                    ->label('أضيفت')
                    ->dateTime('Y-m-d')
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                SelectFilter::make('category_id')
                    ->label('الفئة')
                    ->relationship('category', 'name_ar'),
                SelectFilter::make('region_name_ar')
                    ->label('المنطقة')
                    ->options([
                        'الشمالية' => 'الشمالية',
                        'الجنوبية' => 'الجنوبية',
                        'الشرقية' => 'الشرقية',
                        'الغربية' => 'الغربية',
                        'الوسطى' => 'الوسطى',
                        'الساحلية' => 'الساحلية',
                    ]),
                SelectFilter::make('season')
                    ->label('الفصل')
                    ->options([
                        'ربيع' => 'ربيع',
                        'صيف' => 'صيف',
                        'خريف' => 'خريف',
                        'شتاء' => 'شتاء',
                    ]),
            ])
            ->actions([
                EditAction::make(),
                DeleteAction::make(),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => ListPlants::route('/'),
            'create' => CreatePlant::route('/create'),
            'edit' => EditPlant::route('/{record}/edit'),
        ];
    }
}
